From: javier.martinez@collabora.co.uk (Javier Martinez Canillas)
Date: Mon, 20 Oct 2014 23:47:40 +0200
Subject: [PATCH v3 2/2] ARM: EXYNOS: Call regulator core suspend prepare
 and finish functions
In-Reply-To: <CAD=FV=XnBWWKbrey1zmxtAzGYviJJad4pWOC4=bbf2e2OBgaeQ@mail.gmail.com>
References: <1413839151-10875-1-git-send-email-javier.martinez@collabora.co.uk>	<1413839151-10875-3-git-send-email-javier.martinez@collabora.co.uk>
 <CAD=FV=XnBWWKbrey1zmxtAzGYviJJad4pWOC4=bbf2e2OBgaeQ@mail.gmail.com>
Message-ID: <544582FC.9010005@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Doug,

On 10/20/2014 11:40 PM, Doug Anderson wrote:
> Javier,
> 
> On Mon, Oct 20, 2014 at 2:05 PM, Javier Martinez Canillas
> <javier.martinez@collabora.co.uk> wrote:
>> The regulator framework has a set of helpers functions to be used when
>> the system is entering and leaving from suspend but these are not called
>> on Exynos platforms. This means that the .set_suspend_* function handlers
>> defined by regulator drivers are not called when the system is suspended.
>>
>> Suggested-by: Doug Anderson <dianders@chromium.org>
>> Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
>> Reviewed-by: Doug Anderson <dianders@chromium.org>
> 
> I think you forgot to carry Chanwoo's review:
> 
> Reviewed-by: Chanwoo Choi<cw00.choi@samsung.com>
> 
> I don't think you've made any changes that would need to invalidate his review.
> 

Yes, I forgot to add the tag to my local branch so it was missed when generating
the patch for the new version, sorry about that...

Best regards,
Javier
