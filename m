From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 3 Jul 2012 14:56:11 -0300
Subject: Clock problems in i.MX27 Visstrim M10 (linux-3.5-rc5).
In-Reply-To: <CAOMZO5CeGKJ6kERaCkNE0Cpy2X78CUN_-au5Q+cCtLLjtNXMDg@mail.gmail.com>
References: <CACKLOr0z13sMQhb14YpDp7UtwfhVoqRAMOJCA+geapq=Lh7VuQ@mail.gmail.com>
 <CAOMZO5CeGKJ6kERaCkNE0Cpy2X78CUN_-au5Q+cCtLLjtNXMDg@mail.gmail.com>
Message-ID: <CAOMZO5Bc3jU77+1_nxmhzyD9c17UtCLQzW9CcfPd=pON-wHbOA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 3, 2012 at 10:13 AM, Fabio Estevam <festevam@gmail.com> wrote:
> Hi Javier,
>
> On Tue, Jul 3, 2012 at 8:09 AM, javier Martin
> <javier.martin@vista-silicon.com> wrote:
>> Hi,
>> I've found the following problems in linux-3.5-rc5
>> (6887a4131da3adaab011613776d865f4bcfb5678) in our Visstrim M10 board:
>
> Could you please try the two attached patches?
>
> They should fix the dma and mx2-camera issues.
>
> I will try to look at the ssi problem, but my mx27pdk board still does
> not have audio supported.

Just added audio support to mx27pdk and I could play audio
successfully with the patches I sent you previously.

I will submit them through the proper mailing lists.

Regards,

Fabio Estevam
