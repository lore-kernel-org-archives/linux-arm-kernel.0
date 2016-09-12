From: pku.leo@gmail.com (Leo Li)
Date: Mon, 12 Sep 2016 11:47:37 -0500
Subject: [PATCH v5] i2c: imx: make bus recovery through pinctrl optional
In-Reply-To: <20160909205926.dbxmvhqvfsqzk6dx@pengutronix.de>
References: <1471644322-22670-1-git-send-email-leoyang.li@nxp.com>
 <20160906185849.27pjhawadca5pwow@pengutronix.de>
 <CADRPPNQ+1qBNL5WA=Jo_keE7BPnoOs7a2T6CpTuciiF16qK6xQ@mail.gmail.com>
 <87ca69fb85848a0a86b34a9a9037a57b@agner.ch>
 <CADRPPNSPye45bmFshfwb+gDA0x0ygs4Ofa6HMYbKt9ER0oeccg@mail.gmail.com>
 <8f8f7ffc4aef513ef5064ba0491fbc63@agner.ch>
 <CADRPPNR4oiRVgFqaM=1=Zn_JzrVJDVmozWsouLByXRtaHCh=qQ@mail.gmail.com>
 <306f579a2f2362595a55c53e48657563@agner.ch>
 <CADRPPNS3PecYRaAMR+0RuzU+gE3y5ZN-x7HzqggrdDsN-CkArg@mail.gmail.com>
 <649e7e70becb94adf3b8c4ae2409ea00@agner.ch>
 <20160909205926.dbxmvhqvfsqzk6dx@pengutronix.de>
Message-ID: <CADRPPNQQNW+qz6LywsSA9OHnJ+pp-uSKDXjhvMup55qM7uVcJg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 9, 2016 at 3:59 PM, Uwe Kleine-K?nig
<u.kleine-koenig@pengutronix.de> wrote:
> Hello,
>
> On Fri, Sep 09, 2016 at 01:34:31PM -0700, Stefan Agner wrote:
>> Yeah it is a bit a wording thing: In my understanding, pinctrl is
>> required on SoC's witch have a pin controller... It is just that the
>> driver does not need to get the pinctrl by itself because the stack is
>> taking care of it implicitly. And yes, that makes the particular example
>> not a real world example.
>
> At first I thought, too, that it's a fatal problem if getting the
> pinctrl stuff fails. IMHO that shows that the comments (or the code) are
> still not good enough.

Ya.  If it has confused more than one people, it is likely to confuse
more.  I agree with you that we should make it more clear.

Thanks,
Leo
