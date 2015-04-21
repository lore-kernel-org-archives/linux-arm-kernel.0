From: g.portay@overkiz.com (=?UTF-8?B?R2HDq2wgUE9SVEFZ?=)
Date: Tue, 21 Apr 2015 12:03:58 +0200
Subject: [PATCH] ARM: at91/dt: kizbox: update and rename to at91-kizbox
In-Reply-To: <20150421091100.6bb8ba36@bbrezillon>
References: <1429521218-9752-1-git-send-email-g.portay@overkiz.com>
 <20150421091100.6bb8ba36@bbrezillon>
Message-ID: <5536208E.4060105@overkiz.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21/04/2015 09:11, Boris Brezillon wrote:
> Hi Gael,
>
> On Mon, 20 Apr 2015 11:13:38 +0200
> Ga?l PORTAY <g.portay@overkiz.com> wrote:
>
>> Sort nodes, rename to match Atmel naming convention
> You should use -M when you generate your patches with format-patch: it
> keeps track of files that have been renamed instead of considering it
> as a removal + an addition.

Ok, thanks, I did not know that option...

>> and update the features
>> below:
>>   - command-line,
>>   - use proper serial uart,
>>   - rename leds and gpio-keys,
>>   - update to pwm-leds and
>>   - fix gpio-key level.
> Please split this patch so we can easily review the changes.
> How about the following separation ?
>
> - rename dts file
> - use stdout-path
> - sanitize bootargs
> - led related changes (rename + pwm-leds)
> - gpio-key related changes (rename + fix level)

In fact, each changes were committed in single patch before I submitted 
them...

I just squashed them thinking it would be easier for you to check (only) 
for the "new" device-tree.... my bad :(

What about the node re-order? Do you prefer in dedicated commit or with 
the rename patch?

> Best Regards,
>
> Boris
