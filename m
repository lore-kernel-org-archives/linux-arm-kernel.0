From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 21 Sep 2017 13:38:27 +0200
Subject: [PATCH 01/12] mmc: dt-bindings: update Mediatek MMC bindings
In-Reply-To: <1505355021.8308.4.camel@mhfsdcap03>
References: <1505207272-16983-1-git-send-email-chaotian.jing@mediatek.com>
 <1505207272-16983-2-git-send-email-chaotian.jing@mediatek.com>
 <20170913141026.43oh4n4foipmahsk@rob-hp-laptop>
 <1505355021.8308.4.camel@mhfsdcap03>
Message-ID: <CACRpkdbfCFL3w6bMzT2D2rukhVkzdHPpsfZO6vYQtv_SHSjgOQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 14, 2017 at 4:10 AM, Chaotian Jing
<chaotian.jing@mediatek.com> wrote:
> On Wed, 2017-09-13 at 09:10 -0500, Rob Herring wrote:
>> On Tue, Sep 12, 2017 at 05:07:41PM +0800, Chaotian Jing wrote:

>> > +- mediatek,latch-ck: Some projects do not support enhance_rx, need set correct latch-ck to avoid data crc
>>
>> What's a project?
> eg, MT2701

Replace the word "project" with the word "system" or "SoC" in
your patch.

Yours,
Linus Walleij
