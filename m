From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 16 Oct 2017 14:52:23 +0200
Subject: [PATCH 1/2] drm: bridge: Add bindings for TI THS8134
In-Reply-To: <2446705.uuxjYiEYNm@avalon>
References: <20170901094038.4312-1-linus.walleij@linaro.org>
 <2446705.uuxjYiEYNm@avalon>
Message-ID: <CACRpkda2SDjG--zT+AbCJeqWyAcyNFs6h7AfUUKiDKHiQG2S3A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 13, 2017 at 2:08 AM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:

>> -- compatible: Must be "ti,ths8135"
>> +- compatible: Must be one of
>> +  "ti,ths8134a"
>> +  "ti,ths8134b"
>> +  "ti,ths8135"
>
> As mentioned in the review of patch 2/2, would it make sense to also introduce
> a ti,ths813x compatible string ? I haven't checked the datasheets so the
> answer might very well be no.

That should be fine, compatible-properties from the most specific to the
most generic should work just fine.

I'll respin with a ths813x compatible.

Yours,
Linus Walleij
