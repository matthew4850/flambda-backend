type t

val create : unit -> t

val add_section :
  t -> X86_proc.Section_name.t -> ?body:bytes -> Owee.Owee_elf.section -> unit

val current_offset : t -> int64

val num_sections : t -> int

val get_sec_idx : t -> X86_proc.Section_name.t -> int

val get_section : t -> X86_proc.Section_name.t -> Owee.Owee_elf.section

val get_section_opt :
  t -> X86_proc.Section_name.t -> Owee.Owee_elf.section option

val get_sections : t -> Owee.Owee_elf.section array

val write_bodies : t -> Owee.Owee_buf.t -> unit
