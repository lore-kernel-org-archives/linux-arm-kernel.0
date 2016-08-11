From: robh@kernel.org (Rob Herring)
Date: Thu, 11 Aug 2016 13:44:37 -0500
Subject: [PATCH 1/2] dt: bindings: Add vendor prefix for Espressif System
In-Reply-To: <28c04b6d-c2a4-ac64-2dd8-b8a944b54b1b@redhat.com>
References: <1470596269-20572-1-git-send-email-hdegoede@redhat.com>
 <20160810184845.GA17829@rob-hp-laptop>
 <2b43330e-369d-7473-8b73-429f0f0b73ce@redhat.com>
 <CAL_Jsq+uy-P54enk5Zho=nRab4PMEbqyBTEWiE0yhWWVoFTmwQ@mail.gmail.com>
 <3516eadd-e987-1747-5813-de51b77fd73e@redhat.com>
 <CAL_JsqKLLotHErrfMs-oPvt7GgG1txQtAayjmp4zpCHEMktE_Q@mail.gmail.com>
 <28c04b6d-c2a4-ac64-2dd8-b8a944b54b1b@redhat.com>
Message-ID: <CAL_JsqLeitBkBbCKV7OSbc8==goqqAa1SN_y=7=zEp_zqkm5yw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 11, 2016 at 12:28 PM, Hans de Goede <hdegoede@redhat.com> wrote:
> Hi,
>
> On 11-08-16 18:35, Rob Herring wrote:
>
> <snip>
>
>> I plan to make '_' cause warnings with dtc which is why we don't want
>> to add more.
>
>
> Offtopic question: does this only apply to property names, or
> also to node names ?

Both.

Rob
