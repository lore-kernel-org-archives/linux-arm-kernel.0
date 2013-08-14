From: alexander.shishkin@linux.intel.com (Alexander Shishkin)
Date: Wed, 14 Aug 2013 12:48:23 +0300
Subject: [PATCH v15 00/13] Add tested id switch and vbus connect detect
 support for Chipidea
In-Reply-To: <20130813234303.GA27876@shlinux1.ap.freescale.net>
References: <1376270579-13493-1-git-send-email-peter.chen@freescale.com>
 <20130813234303.GA27876@shlinux1.ap.freescale.net>
Message-ID: <87a9kka9i0.fsf@ashishki-desk.ger.corp.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Peter Chen <peter.chen@freescale.com> writes:

> On Mon, Aug 12, 2013 at 09:22:46AM +0800, Peter Chen wrote:
>> This patchset adds tested otg id switch function and vbus connect
>> and disconnect detection for chipidea driver. And fix kinds of 
>> bugs found at chipidea drivers after enabling id and vbus detection.
>> 
>> This patch are fully tested at imx6 sabresd and imx28evk platform by me.
>> Besides, marek tested it on two STMP3780-based boards (not yet mainline)
>> and two MX28-based boards.
>> 
>> My chipidea repo: https://github.com/hzpeterchen/linux-usb.git
>
> Hi Alex,
>
> I see Felipe has already sent his pull request for 3.12 merge
> windows. Would you please speed up review my chipidea patches?
> At least, I hope this serial can be queued at 3.12. Thanks.

Yes, it is about time.

Thanks,
--
Alex
