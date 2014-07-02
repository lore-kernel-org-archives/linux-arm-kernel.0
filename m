From: airlied@gmail.com (Dave Airlie)
Date: Wed, 2 Jul 2014 14:08:02 +1000
Subject: [PATCH/RESEND 0/9] drm: tilcdc driver fixes
In-Reply-To: <53B36EF1.8060200@ti.com>
References: <1402110128-30471-1-git-send-email-guido@vanguardiasur.com.ar>
 <1403014631-18072-1-git-send-email-guido@vanguardiasur.com.ar>
 <53ADEB73.8090301@ti.com> <20140701233958.GA31549@fox>
 <53B36EF1.8060200@ti.com>
Message-ID: <CAPM=9tzQR446Xc2xnrSOGa+VetO44KskMFrkPqbatwsmv1dHXQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2 July 2014 12:31, Darren Etheridge <detheridge@ti.com> wrote:
> On 07/01/2014 06:39 PM, Guido Mart?nez wrote:
>>
>> On Fri, Jun 27, 2014 at 05:08:51PM -0500, Darren Etheridge wrote:
>>>
>>> [snip]
>>>
>>> Otherwise I think this is a good and useful patch series.
>>
>> It that a Tested-by tag? :)
>
>
> Sure - I would prefer that the WARN_ON was silenced when the tilcdc module
> is removed, but the series adds improvements over what is there now.  I have
> tested it across a few variants of AM335x boards and attached display
> hardware in both module form and built-in to the kernel, therefore:
>
> Tested-by: Darren Etheridge <detheridge@ti.com>

Has someone gathered that tags and put these in a git tree by any chance?

Dave.
