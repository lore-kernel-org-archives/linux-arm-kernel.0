From: hdegoede@redhat.com (Hans de Goede)
Date: Tue, 29 Dec 2015 13:33:38 +0100
Subject: [linux-sunxi] Re: [PATCH] ARM: dts: sun4i: Use red1 LED for
 heartbeat indication on Marsboard A10
In-Reply-To: <20151227205151.GK30359@lukather>
References: <1451123879-7212-1-git-send-email-mamlinav@gmail.com>
 <20151227205151.GK30359@lukather>
Message-ID: <56827DA2.2060006@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 27-12-15 21:51, Maxime Ripard wrote:
> On Sat, Dec 26, 2015 at 12:57:59PM +0300, Aleksei Mamlin wrote:
>> Marsboard A10 have four red LEDs, the first one can be used for
>> heartbeat indication.
>>
>> Signed-off-by: Aleksei Mamlin <mamlinav@gmail.com>
>
> I'm really not sure about this one.
>
> This is something that can easily be changed through sysfs, and it
> will likely end up being a "war" on what trigger people want to use.
>
> Hans, Chen-Yu, What's your view on this?

I would prefer to not set any (default) led triggers in the dts
files for sunxi boards.

Regards,

Hans
