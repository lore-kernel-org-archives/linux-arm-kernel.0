From: govindraj.ti@gmail.com (Govindraj)
Date: Mon, 27 Jun 2011 18:21:02 +0530
Subject: [PATCH v3 09/12] OMAP3: Serial: Remove uart pads from 3430 board
	file.
In-Reply-To: <8739iyx3r1.fsf@ti.com>
References: <1307532194-13039-1-git-send-email-govindraj.raja@ti.com>
	<1307532194-13039-10-git-send-email-govindraj.raja@ti.com>
	<8739iyx3r1.fsf@ti.com>
Message-ID: <BANLkTikYfkGOhjG50wUBby5HmNwKLdk4bw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jun 25, 2011 at 3:59 AM, Kevin Hilman <khilman@ti.com> wrote:
> "Govindraj.R" <govindraj.raja@ti.com> writes:
>
>> The pad values here are same as the default pad values updated in
>> serial.c file.
>> Avoid structure duplication and use default pads.
>>
>> Signed-off-by: Govindraj.R <govindraj.raja@ti.com>
>
> This should be folded in with [03/12]

agree.

--
Govindraj.R

>
> Kevin
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at ?http://vger.kernel.org/majordomo-info.html
>
