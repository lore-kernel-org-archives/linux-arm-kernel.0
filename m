From: arnaud.patard@rtp-net.org (Arnaud Patard (Rtp))
Date: Wed, 20 Oct 2010 10:13:17 +0200
Subject: [patch 9/9] efikamx: add reset
In-Reply-To: <636242.78053.qm@web51007.mail.re2.yahoo.com> (Fabio Estevam's
	message of "Tue\, 19 Oct 2010 16\:51\:20 -0700 \(PDT\)")
References: <636242.78053.qm@web51007.mail.re2.yahoo.com>
Message-ID: <87vd4xcmea.fsf@lechat.rtp-net.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fabio Estevam <fabioestevam@yahoo.com> writes:

> Hi Arnaud,

Hi,
>
> --- On Tue, 10/19/10, Arnaud Patard <arnaud.patard@rtp-net.org> wrote:
> ...
>> +void mx51_efikamx_reset(int mode, const char *cmd)
>> +{
>> +??? if (system_rev == 0x11)
>> +??? ???
>
> Couldn't it be void mx51_efikamx_reset(void) instead?
>
> 'mode' and 'cmd' are not being used.

I took the same prototype as arch_reset() but I can remove it (and will
do).

Thanks,
Arnaud
