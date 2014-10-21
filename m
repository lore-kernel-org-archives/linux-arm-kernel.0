From: hdegoede@redhat.com (Hans de Goede)
Date: Tue, 21 Oct 2014 22:29:51 +0200
Subject: [PATCH v2 3/4] ARM: dts: sun5i: Add lradc node
In-Reply-To: <20141021162159.GC8609@dtor-ws>
References: <1413879890-7254-1-git-send-email-hdegoede@redhat.com>
 <1413879890-7254-4-git-send-email-hdegoede@redhat.com>
 <20141021162159.GC8609@dtor-ws>
Message-ID: <5446C23F.3040604@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 10/21/2014 06:21 PM, Dmitry Torokhov wrote:
> Hi Hans,
>
> On Tue, Oct 21, 2014 at 10:24:49AM +0200, Hans de Goede wrote:
>> +			button at 98 {
>> +				label = "Home";
>> +				linux,code = <KEY_HOME>;
>
> I do not think you really want KEY_HOME (go to the beginning of the
> line) here, KEY_HOMEPAGE or similar would suit better.

I can understand where you're coming from, but KEY_HOME is what these
keys typically send under android, and what android expects them to
send...

Not sure if that is a good argument to keep it as KEY_HOME though.

Please let me know which way you want this key to be mapped, and
I'll update it for the next version.

Regards,

Hans
