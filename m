From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 19 May 2014 10:12:26 -0300
Subject: [PATCH v5 2/2] ARM: dts: mx51: Remove mach-cpuimx51sd board file
In-Reply-To: <1400501288.2007.37.camel@x220>
References: <1399736856-9489-1-git-send-email-festevam@gmail.com>
 <1399736856-9489-2-git-send-email-festevam@gmail.com>
 <20140513015431.GI8330@dragon> <1400492895.2007.7.camel@x220>
 <CAOMZO5ArKGZfqSZurMpsGA28MxNRmqcnYc38G8rR3axVDfwaaQ@mail.gmail.com>
 <1400501288.2007.37.camel@x220>
Message-ID: <CAOMZO5DkHpaLq1YSB+Ny88_wQoN3nf_9AJmw77BmRA6ZTkkNDA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 19, 2014 at 9:08 AM, Paul Bolle <pebolle@tiscali.nl> wrote:
> On Mon, 2014-05-19 at 08:57 -0300, Fabio Estevam wrote:
>> MACH_EUKREA_MBIMXSD51_BASEBOARD should be removed from sound/soc/fsl/Kconfig.
>
> Thanks for looking into this.
>
>> Would you like to submit a patch?
>
> Only if all you want for a commit explanation is something like "Remove
> a select statement for MACH_EUKREA_MBIMXSD51_BASEBOARD. It's a NOP".
>
> But I suppose it might be nice to add a few lines why removing config
> MACH_EUKREA_MBIMXSD51_BASEBOARD didn't break the code (that is enabled
> by setting SND_SOC_EUKREA_TLV320). And I wouldn't know how to write
> those lines, because I have no idea how this all fits together. So I
> actually prefer if someone else submitted that patch.
>
> But I do hope you don't mind if I drop in a reminder if that patch takes
> too long.

No problem. I can send a patch for this when 3.16-rc1 is out.
