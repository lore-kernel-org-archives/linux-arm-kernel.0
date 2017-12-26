From: robh@kernel.org (Rob Herring)
Date: Tue, 26 Dec 2017 16:50:18 -0600
Subject: [PATCHv3 RESEND 1/3] Documentation: dt: memory: ti-emif: add edac
 support under emif
In-Reply-To: <20171226224819.6uekbnbd5tllaxb5@rob-hp-laptop>
References: <1513959834-27901-1-git-send-email-t-kristo@ti.com>
 <20171226224819.6uekbnbd5tllaxb5@rob-hp-laptop>
Message-ID: <CAL_Jsq+9=Py6tGgTQSKnBb3xJstPm=3cTP=pqWcCLvMJ83ajyQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 26, 2017 at 4:48 PM, Rob Herring <robh@kernel.org> wrote:
> On Fri, Dec 22, 2017 at 06:23:54PM +0200, Tero Kristo wrote:
>> Certain revisions of the TI EMIF IP contain ECC support in them. Reflect
>> this in the DT binding.
>
> "dt-bindings: edac: ..." is the preferred subject prefix.

Err, I mean "dt-bindings: memory-controllers: ..."

Rob
