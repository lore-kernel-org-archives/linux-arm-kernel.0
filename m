From: linus.walleij@linaro.org (Linus Walleij)
Date: Sat, 13 Feb 2016 20:07:02 +0100
Subject: [PATCH 2/2] dt-bindings: Add TPO TPG110 binding
In-Reply-To: <20160202162833.GB4918@ulmo>
References: <1454316643-3931-1-git-send-email-linus.walleij@linaro.org>
 <20160202162833.GB4918@ulmo>
Message-ID: <CACRpkdY77MsH5ArGo7Wh8qhUNYJhWHLOZRN4j=4YQKYsvVbnmQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 2, 2016 at 5:28 PM, Thierry Reding <thierry.reding@gmail.com> wrote:
> On Mon, Feb 01, 2016 at 09:50:43AM +0100, Linus Walleij wrote:

>> +This binding builds on the DPI bindings, adding a few properties
>> +as a superset of a DPI. See panel-dpi.txt for the required DPI
>> +bindings.
>
> It is unfortunate that we have these two types of bindings, one used by
> some of the legacy fbdev drivers and the other by DRM/KMS drivers. There
> isn't really much we can do about it, though, as far as I can see.

I wasn't aware that they were any different. Where is the equivalent
binding for DRM/KMS panels?

I guess one must have been merged first and the second one screwed
up by not reusing the first one :(

> This panel is used with an fbdev driver, right?

Yes.

I don't know if I will be able to convert the AMBA CLCD driver from
fbdev to DRM/KMS but I was hoping I would not have to change the
DT to redescribe the same hardware for that, but now it sounds
like that is a consequence...

Yours,
Linus Walleij
