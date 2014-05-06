From: emilio@elopez.com.ar (=?ISO-8859-1?Q?Emilio_L=F3pez?=)
Date: Tue, 06 May 2014 17:24:08 -0300
Subject: [PATCH v10 01/15] clk: sunxi: factors: automatic reparenting
 support
In-Reply-To: <20140506185131.GI9464@lukather>
References: <1399046249-19472-1-git-send-email-hdegoede@redhat.com>
 <1399046249-19472-2-git-send-email-hdegoede@redhat.com>
 <20140506185131.GI9464@lukather>
Message-ID: <536944E8.5060300@elopez.com.ar>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

El 06/05/14 15:51, Maxime Ripard escribi?:
> Hi Emilio,
>
> On Fri, May 02, 2014 at 05:57:15PM +0200, Hans de Goede wrote:
>> From: Emilio L?pez <emilio@elopez.com.ar>
>>
>> This commit implements .determine_rate, so that our factor clocks can be
>> reparented when needed.
>>
>> Signed-off-by: Emilio L?pez <emilio@elopez.com.ar>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>
>
> Any chance you merge this? Since it's pretty consensual, needed by
> other drivers, and that you are the author, I can it can go in.

I merged it on my tree for Mike on April 22nd

http://lists.infradead.org/pipermail/linux-arm-kernel/2014-April/249259.html

It seems Mike has taken another copy for 3.16 though

http://lists.infradead.org/pipermail/linux-arm-kernel/2014-May/253661.html

Mike, do you want to drop the patches and have me take both of them, or 
would you prefer it if I dropped my copy?

Cheers,

Emilio
