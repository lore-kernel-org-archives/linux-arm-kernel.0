From: robh@kernel.org (Rob Herring)
Date: Tue, 26 Dec 2017 11:25:08 -0600
Subject: [PATCH v2 1/5] drm/panel: Add support for the EDT ETM0700G0BDH6
In-Reply-To: <95F51F4B902CAC40AF459205F6322F01B7FDFECC3D@BMK019S01.emtrion.local>
References: <95F51F4B902CAC40AF459205F6322F01B7FDFECC3D@BMK019S01.emtrion.local>
Message-ID: <CAL_JsqL8Yny=tm23jbJTMvM2OdXUE3d1A+h4d2kNARHnLgLMkA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 22, 2017 at 4:43 AM, T?rk, Jan <Jan.Tuerk@emtrion.de> wrote:
>> Von: Rob Herring [mailto:robh at kernel.org]
>> Gesendet: Freitag, 22. Dezember 2017 00:00
>> Betreff: Re: [PATCH v2 1/5] drm/panel: Add support for the EDT
>> ETM0700G0BDH6
>>
>> On Wed, Dec 20, 2017 at 02:47:01PM +0100, jan.tuerk at emtrion.com wrote:
>> > From: Jan Tuerk <jan.tuerk@emtrion.com>
>> >
>> > The Emerging Display Technology ETM0700G0BDH6 is exactly the same
>> > display as the ETM0700G0DH6, exept the pixelclock polarity. Therefore
>> > re-use the ETM0700G0DH6 modes. It is used by default on emtrion Avari
>> > based development kits.
>>
>> As I asked on v1, why not document the panels together in a single doc?
>
> As denoted in the cover letter:

I generally don't read cover letters...

>>The documentation for the EDT display is kept as an extra file currently,
>>as it is done by the most displays in the documentation. Also a new
>>new Variant of the EDT already arrived. So merging their documentations
>>should be discussed separately.

You mean a 3rd variant?

> I think it will be even a little tricky to find a matching filename for both versions,
> as the recent ones adding an extra character in the description. Are you expecting sth.
> like edt,etm0700series.txt?

Yeah, or edt,etm0700g0.txt.

Rob
