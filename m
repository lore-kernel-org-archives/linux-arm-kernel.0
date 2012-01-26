From: jean.pihet@newoldbits.com (Jean Pihet)
Date: Thu, 26 Jan 2012 13:22:05 +0100
Subject: [PATCH 17/21] OMAP3430: SR: class3: restrict CPU to run on
In-Reply-To: <4F2139F1.6060908@ru.mvista.com>
References: <1327504583-13408-1-git-send-email-j-pihet@ti.com>
 <1327504583-13408-18-git-send-email-j-pihet@ti.com>
 <4F2139F1.6060908@ru.mvista.com>
Message-ID: <CAORVsuVPwgONiE3_SdONSB2at5L4hmT=vV5ipyOhEEbJ-X6DAw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sergei,

On Thu, Jan 26, 2012 at 12:33 PM, Sergei Shtylyov
<sshtylyov@ru.mvista.com> wrote:
> Hello.
>
>
> On 25-01-2012 19:16, Jean Pihet wrote:
>
>> From: Nishanth Menon<nm@ti.com>
>
>
>> Use SmartReflex AVS Class3 initialization only for OMAP343x family of
>> processors.
>
>
>> Change-Id: I660326bf265541ba4e0feb52853ff6cb9b293aed
>
>
> ? All patchjes from Nishanth Menon seem to contain this line. Please remove
> it...
OK done in the next revision, sorry about that.
That 'Change-Id' line seems to have very much success on the mailing list ;p

Thanks for reviewing,
Jean

>
>
>> Signed-off-by: Nishanth Menon<nm@ti.com>
>> Signed-off-by: Jean Pihet<j-pihet@ti.com>
>
>
> WBR, Sergei
>
