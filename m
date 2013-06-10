From: jp.francois@cynove.com (jean-philippe francois)
Date: Mon, 10 Jun 2013 10:03:23 +0200
Subject: [PATCH v2 1/1] ARM : omap3 : fix wrong container_of in clock36xx.c
In-Reply-To: <alpine.DEB.2.02.1306061517430.5152@utopia.booyaka.com>
References: <1369903827-2025-1-git-send-email-jp.francois@cynove.com>
 <alpine.DEB.2.02.1306051814520.10103@utopia.booyaka.com>
 <CAGGh5h1gBin0vWFf=SpB4eCQX69a2U+J6u2ccF_Oo_4R62+5fQ@mail.gmail.com>
 <alpine.DEB.2.02.1306061517430.5152@utopia.booyaka.com>
Message-ID: <CAGGh5h0z3OPPL_jECb1NhENo2OaBqebdTC6r_ddhWKDuuB1Ykg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2013/6/6 Paul Walmsley <paul@pwsan.com>:
> On Thu, 6 Jun 2013, jean-philippe francois wrote:
>
>> Does the first version [1] of the patch, that only touch the MSB of
>> the divider also trigger the
>> bug ?
>>
>> [1]  https://patchwork.kernel.org/patch/2609681/
>
> That one passes the PM test here.  Will take this one for v3.10-rc fixes
> instead, since it fixes a known DSS problem and the original code wasn't
> correct.
>
> Jean, could you work with Mike to come up with a better approach for
> v3.11 or v3.12?
>
Hi,

I am ok to work on it, however could you explain to me what is the
expected output of your PM tests, and how to reproduce them ?
The board I used to test the clock frequency was correct suffered from
heavy handed oscilloscope probing and is currently out of order :(

Jean-Philippe Fran?ois.

>
> - Paul
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
