From: roy.franz@linaro.org (Roy Franz)
Date: Tue, 10 Dec 2013 10:29:34 -0800
Subject: [PATCH v3 1/3] Documentation: arm: add UEFI support documentation
In-Reply-To: <20131210123035.D1586C40A27@trevor.secretlab.ca>
References: <1385656883-4420-1-git-send-email-leif.lindholm@linaro.org>
 <CAHCPf3s_SXYXLRwvn7tzqTCQ-gB=emRMK_dXkEmw_HWigiD7Mw@mail.gmail.com>
 <20131210123035.D1586C40A27@trevor.secretlab.ca>
Message-ID: <CAFECyb93r5QGWRYDQxzWJ-xtptWBAEiQtAx=woLC5x+3WhbNqQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 10, 2013 at 4:30 AM, Grant Likely <grant.likely@linaro.org> wrote:
> On Fri, 6 Dec 2013 11:20:45 -0600, Matt Sealey <neko@bakuhatsu.net> wrote:
>> On Wed, Dec 4, 2013 at 4:44 PM, Matthew Garrett <mjg59@srcf.ucam.org> wrote:
>> > On Wed, Dec 04, 2013 at 03:06:47PM -0600, Matt Sealey wrote:
>> Grant suggested I should propose some patches; sure, if I'm not otherwise busy.
>>
>> Maybe the Linaro guys can recommend a platform (real or emulated) that
>> would be best to test it on with the available UEFI?
>
> Roy Franz (cc'd) has got UEFI running under QEMU. A few modifications
> were required to both stock UEFI and QEMU. I'm not sure what the status
> of mainlining those patches is. I think there are still a few things
> that Roy has to fix, but you should be able to get the current patches
> from him to get going.
>
> g.
>

Hi Grant and Matt,

I have put together a quick wiki page describing the current status,
with git trees for
UEFI and QEMU, and instructions for running the model.  I just whipped
this up now, so it
is pretty basic, but should have all the required information.

https://wiki.linaro.org/LEG/Engineering/Kernel/UEFI/VersatileExpress/QEMU

Please let me know if you have any questions.

Thanks,
Roy
