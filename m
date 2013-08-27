From: alexander.shishkin@linux.intel.com (Alexander Shishkin)
Date: Tue, 27 Aug 2013 11:09:48 +0300
Subject: [PATCH v15 00/13] Add tested id switch and vbus connect detect
 support for Chipidea
In-Reply-To: <521C4FEF.2010905@digi.com>
References: <1376270579-13493-1-git-send-email-peter.chen@freescale.com>
 <521B8150.70906@digi.com> <20130827025115.GA6561@shlinux1.ap.freescale.net>
 <521C4FEF.2010905@digi.com>
Message-ID: <87k3j77dwz.fsf@ashishki-desk.ger.corp.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hector Palacios <hector.palacios@digi.com> writes:

> Dear Peter,
>
> On 08/27/2013 04:51 AM, Peter Chen wrote:
>> On Mon, Aug 26, 2013 at 06:24:48PM +0200, Hector Palacios wrote:
>>> Dear Peter,
>>>
>>> On 08/12/2013 03:22 AM, Peter Chen wrote:
>>>> This patchset adds tested otg id switch function and vbus connect
>>>> and disconnect detection for chipidea driver. And fix kinds of
>>>> bugs found at chipidea drivers after enabling id and vbus detection.
>>>>
>>>> This patch are fully tested at imx6 sabresd and imx28evk platform by me.
>>>> Besides, marek tested it on two STMP3780-based boards (not yet mainline)
>>>> and two MX28-based boards.
>>>>
>>>> My chipidea repo: https://github.com/hzpeterchen/linux-usb.git
>>>>
>>>> Changes for v15:
>>>> - Mark otgsc API as static line, and move them to otg.h [4/13]
>>>> - Remove some redundant comments [6/13]
>>>> - Fix some typos [8/13]
>>>> - Retire flag CI_HDRC_PULLUP_ON_VBUS [12/13] [13/13]
>>>
>>> Patches 6 and 12 in this series seem to be incomplete or malformed. Please check.
>>>
>>
>> Would you post what's the problem for them or what's problem
>> at your system after using them?
>
> I'm sorry, I thought it was evident. Patches 6 and 12 were posted incomplete. See how 
> they end:
> http://permalink.gmane.org/gmane.linux.usb.general/92231
> http://permalink.gmane.org/gmane.linux.usb.general/92237
>
> In patch 12 the modified file include/linux/usb/chipidea.h does not even appear.
> Something happened during the generation or posting of these patches.

Or something's wrong with gmane.

http://www.spinics.net/lists/linux-usb/msg91695.html
