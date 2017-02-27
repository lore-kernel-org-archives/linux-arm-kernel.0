From: robh@kernel.org (Rob Herring)
Date: Mon, 27 Feb 2017 16:18:32 -0600
Subject: [PATCH 1/2] devicetree: Add vendor prefix for Hwacom Systems Inc.
In-Reply-To: <b2f85993-7ee3-80f2-066d-66582c06ad14@suse.de>
References: <20170212193247.22705-1-carlo@caione.org>
 <20170212193247.22705-2-carlo@caione.org>
 <20170222142558.wbedfw6l4maatkdy@rob-hp-laptop> <m2mvd839t7.fsf@baylibre.com>
 <CAL_Jsq+O4gpf7Hbfx_+ppe0uVpbzxJdk49jsytsYmyP4GZyUfQ@mail.gmail.com>
 <b2f85993-7ee3-80f2-066d-66582c06ad14@suse.de>
Message-ID: <CAL_Jsq+aKb3ah8rKvjgg5XoLLnVWfvu+dEXapggMYwe63HY6Kg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 27, 2017 at 1:02 PM, Andreas F?rber <afaerber@suse.de> wrote:
> Am 27.02.2017 um 14:29 schrieb Rob Herring:
>> On Sun, Feb 26, 2017 at 3:45 PM, Kevin Hilman <khilman@baylibre.com> wrote:
>>> Rob Herring <robh@kernel.org> writes:
>>>
>>>> On Sun, Feb 12, 2017 at 08:32:46PM +0100, Carlo Caione wrote:
>>>>> From: Carlo Caione <carlo@endlessm.com>
>>>>>
>>>>> Hwacom Systems Inc. is a broadband system integrator and supplier of
>>>>> mobile, fixed and IP networks related services as well as
>>>>> multimedia application. Website: http://www.hwacom.com/
>>>>>
>>>>> Signed-off-by: Carlo Caione <carlo@endlessm.com>
>>>>> ---
>>>>>  Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
>>>>>  1 file changed, 1 insertion(+)
>>>>
>>>> Acked-by: Rob Herring <robh@kernel.org>
>>>
>>> Rob, I assume I should take this patch along with the patch that's using
>>> this prefix?  Or does this go through some other DT path?
>>
>> Yes, it should be applied with the rest of the series.
>
> Elsewhere Rob requested that "dt-bindings: " be used in $subject BTW.
> Does that not apply to vendor prefixes, or should Kevin fix that when
> applying?

Yes, it does apply, but it's fine leaving as-is.

Rob
