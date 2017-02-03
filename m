From: dhowells@redhat.com (David Howells)
Date: Fri, 03 Feb 2017 17:19:07 +0000
Subject: [PATCH 7/7] efi: Print the secure boot status in x86 setup_arch()
 [ver #7]
In-Reply-To: <CAKv+Gu88XuQAb7aSmJ=b+u5LDfkE=dgWMwnKUd0U=qKSQXxdrQ@mail.gmail.com>
References: <CAKv+Gu88XuQAb7aSmJ=b+u5LDfkE=dgWMwnKUd0U=qKSQXxdrQ@mail.gmail.com>
 <CAKv+Gu-=-piH7FQF92T6Yn4KUHLQ-C4CtexWe8D27Tuc3h8KdA@mail.gmail.com>
 <148587558696.4026.16034622623568539004.stgit@warthog.procyon.org.uk>
 <148587565838.4026.2835771993519594392.stgit@warthog.procyon.org.uk>
 <CAKv+Gu8otPYWcKw72zP2q+34JAzZ-QRy8xGFmbStO6WseeANdw@mail.gmail.com>
 <13280.1486138918@warthog.procyon.org.uk>
 <13531.1486139256@warthog.procyon.org.uk>
 <13569.1486139355@warthog.procyon.org.uk>
 <CAKv+Gu-O+nWmu2s8bCrANJs0JNE4QgaM=ZkSa+bu60C=-6T-Lg@mail.gmail.com>
Message-ID: <24335.1486142347@warthog.procyon.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:

> OK, I have queued these patches (minus the DeployedMode one) in the
> next branch on efi.git. Please double check, I will send out a pull
> request to tip shortly (once the autobuilder gives me the green light)

Looks okay.  Now if I can just squeeze a fixed grub2 out of Peter Jones...

David
