From: khilman@baylibre.com (Kevin Hilman)
Date: Mon, 31 Oct 2016 12:23:54 -0600
Subject: [RFC PATCH 01/13] pinctrl: meson: Add GXL pinctrl definitions
In-Reply-To: <b80010f7-196a-abeb-e4a2-5009f3b7f13b@baylibre.com> (Neil
 Armstrong's message of "Mon, 31 Oct 2016 10:40:24 +0100")
References: <1477060838-14164-1-git-send-email-narmstrong@baylibre.com>
 <1477060838-14164-2-git-send-email-narmstrong@baylibre.com>
 <CACRpkdZ5VG2NGRh5CmYcYzwCp0LYSsgxHogCFa+6W7BDDBXOYg@mail.gmail.com>
 <b80010f7-196a-abeb-e4a2-5009f3b7f13b@baylibre.com>
Message-ID: <m27f8o2x8l.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Neil Armstrong <narmstrong@baylibre.com> writes:

> On 10/24/2016 03:03 AM, Linus Walleij wrote:
>> On Fri, Oct 21, 2016 at 4:40 PM, Neil Armstrong <narmstrong@baylibre.com> wrote:
>> 
>>> Add support for the Amlogic Meson GXL SoC, this is a partially complete
>>> definition only based on the Amlogic Vendor tree.
>>>
>>> This definition differs a lot from the GXBB and needs a separate entry.
>>>
>>> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
>> 
>> Looks good to me. Tell me when I may apply it, it looks orthogonal
>> to the rest of the patches.
>> 
>> Yours,
>> Linus Walleij
>> 
>
> Hi Linus,
>
> I'm ok to have it applied as soon as possible, but I can send a clean non-rfc patch if needed.
>

Acked-by: Kevin Hilman <khilman@baylibre.com>

I was hoping to have a bit clearer info from the vendor, but based on
vendor BSP, I think we have most of the info, and can do the minor
fixups if/when we get detailed documentation.

Kevin
