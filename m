From: dhowells@redhat.com (David Howells)
Date: Fri, 03 Feb 2017 16:29:15 +0000
Subject: [PATCH 7/7] efi: Print the secure boot status in x86 setup_arch()
 [ver #7]
In-Reply-To: <13531.1486139256@warthog.procyon.org.uk>
References: <13531.1486139256@warthog.procyon.org.uk>
 <CAKv+Gu-=-piH7FQF92T6Yn4KUHLQ-C4CtexWe8D27Tuc3h8KdA@mail.gmail.com>
 <148587558696.4026.16034622623568539004.stgit@warthog.procyon.org.uk>
 <148587565838.4026.2835771993519594392.stgit@warthog.procyon.org.uk>
 <CAKv+Gu8otPYWcKw72zP2q+34JAzZ-QRy8xGFmbStO6WseeANdw@mail.gmail.com>
 <13280.1486138918@warthog.procyon.org.uk>
Message-ID: <13569.1486139355@warthog.procyon.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

David Howells <dhowells@redhat.com> wrote:

> Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> 
> > Yes, but only if you are booting via UEFI, no?
> 
> Why limit it so?  Even if you don't boot via UEFI, the bootloader/kexec can
> always set the secure-boot state on.
> 
> > So perhaps use efi_enabled(EFI_BOOT) instead?
> 
> I've no objection to that, given it incorporates a test of CONFIG_EFI.

Feel free to just go ahead and change it in the patch.  We can always take the
check out later.

David
