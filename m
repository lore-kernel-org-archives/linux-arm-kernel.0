From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 26 Aug 2013 10:43:09 -0600
Subject: [PATCHv4 1/4] arm: dts: Add clock entries for timers in SOCFPGA
In-Reply-To: <1377301176.7061.2.camel@linux-builds1>
References: <1377189026-16656-1-git-send-email-dinguyen@altera.com>
 <1377301176.7061.2.camel@linux-builds1>
Message-ID: <521B859D.5010609@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/23/2013 05:39 PM, Dinh Nguyen wrote:
> Hi Stephen,
> 
> On Thu, 2013-08-22 at 11:30 -0500, Dinh Nguyen wrote:
>> From: Dinh Nguyen <dinguyen@altera.com>
>>
>> Set the correct clock entries for the the timers, and also clean up
>> the timer entries for SOCFPGA by removing timer<n> in the timer entry.
...
> Not sure if you our Ack for:
> [
> PATCHv4 2/4] arm: dts: Change dw-apb-timer-osc and dw-apb-timer-sp to
> just dw-apb-timer
> 
> applies to this one too. But just in case, can I get your Ack for this
> one too?

I only reviewed the binding changes, not the DT file changes themselves;
I don't really want to set a precedent for that, or it'll increase the
review volume too much.
