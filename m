From: tarun.kanti@ti.com (DebBarma, Tarun Kanti)
Date: Thu, 8 Mar 2012 09:04:27 +0530
Subject: [PATCH v3 10/13] gpio/omap: fix missing dataout context save in
 _set_gpio_dataout_reg
In-Reply-To: <4F574EA6.4000807@ti.com>
References: <1331118963-26364-1-git-send-email-tarun.kanti@ti.com>
 <1331118963-26364-11-git-send-email-tarun.kanti@ti.com>
 <4F574EA6.4000807@ti.com>
Message-ID: <CAC83ZvKuOfd3kxJSdsU2W_si92zzAOn+gpvLAcVOfPdsEH8+gA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 7, 2012 at 5:33 PM, Santosh Shilimkar
<santosh.shilimkar@ti.com> wrote:
> On Wednesday 07 March 2012 12:16 PM, Tarun Kanti DebBarma wrote:
>> There are two functions, _set_gpio_dataout_reg() and _set_gpio_dataout_mask()
>> which writes to dataout register and the dataout context must be saved.
>> It is missing in the first function, _set_gpio_dataout_reg(). Fix this.
>>
>> Reported-by: Govindraj Raja <govindraj.raja@ti.com>
>> Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
>> ---
> Good catch. Is the suspend/resume caught this issue?
That's right.
--
Tarun
>
> This can go as a fix as well.
>
> Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
>
> Regards
> Santosh
