From: hdegoede@redhat.com (Hans de Goede)
Date: Wed, 22 Oct 2014 12:42:32 +0200
Subject: [linux-sunxi] Re: [PATCH v2 3/4] ARM: dts: sun5i: Add lradc node
In-Reply-To: <5446C23F.3040604@redhat.com>
References: <1413879890-7254-1-git-send-email-hdegoede@redhat.com>
 <1413879890-7254-4-git-send-email-hdegoede@redhat.com>
 <20141021162159.GC8609@dtor-ws> <5446C23F.3040604@redhat.com>
Message-ID: <54478A18.3070704@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 10/21/2014 10:29 PM, Hans de Goede wrote:
> Hi,
> 
> On 10/21/2014 06:21 PM, Dmitry Torokhov wrote:
>> Hi Hans,
>>
>> On Tue, Oct 21, 2014 at 10:24:49AM +0200, Hans de Goede wrote:
>>> +            button at 98 {
>>> +                label = "Home";
>>> +                linux,code = <KEY_HOME>;
>>
>> I do not think you really want KEY_HOME (go to the beginning of the
>> line) here, KEY_HOMEPAGE or similar would suit better.
> 
> I can understand where you're coming from, but KEY_HOME is what these
> keys typically send under android, and what android expects them to
> send...
> 
> Not sure if that is a good argument to keep it as KEY_HOME though.
> 
> Please let me know which way you want this key to be mapped, and
> I'll update it for the next version.

Sleeping a night on this I fully agree that what android is doing /
expecting here is just plain wrong, so I'll change this to KEY_HOMEPAGE
when I respin the set.

Regards,

Hans
