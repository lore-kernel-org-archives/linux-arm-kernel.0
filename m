From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Tue, 31 Jan 2017 18:20:45 +0000
Subject: [PATCH 0/7] efi: Pass secure boot mode to kernel [ver #7]
In-Reply-To: <8425.1485882280@warthog.procyon.org.uk>
References: <148587558696.4026.16034622623568539004.stgit@warthog.procyon.org.uk>
 <CAKv+Gu9cTtmV+9-kWSzvFui7KHxrG6MsUfz0VET=714m2cGhbQ@mail.gmail.com>
 <8425.1485882280@warthog.procyon.org.uk>
Message-ID: <CAKv+Gu97mxVv+CvvdwTZfXgWMnnZDJNseyX58N2xMH4dcNV9Sg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 31 January 2017 at 17:04, David Howells <dhowells@redhat.com> wrote:
> Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
>
>> Could you please resend with the [ver #7] removed from the subject
>> lines? It is a bit tedious to have to manually modify each patch when
>> applying.
>

This looks mostly fine to me (modulo the DeployedMode patch I just
replied to) but Matt needs to look at the x86 bits.
