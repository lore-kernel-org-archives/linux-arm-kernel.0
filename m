From: maxime.coquelin@st.com (Maxime Coquelin)
Date: Mon, 10 Nov 2014 11:27:16 +0100
Subject: ARM: sti: SOC_STIH407 and STIH407_RESET?
In-Reply-To: <1415614934.4862.22.camel@x220>
References: <1415614934.4862.22.camel@x220>
Message-ID: <54609304.4080209@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Paul,
On 11/10/2014 11:22 AM, Paul Bolle wrote:
> Your commit c27321141915 ("ARM: sti: Add STiH407 Kconfig entry to select
> STIH407_RESET") was included in today's linux-next (ie, next-20141110).
> It adds a Kconfig entry for SOC_STIH407. That entry selects
> STIH407_RESET.
>
> There's no Kconfig symbol STIH407_RESET. And there's nothing in
> next-20141110 that cares about SOC_STIH407. So this entry is currently a
> nop.
>
> I assume that there are one or more patches queued that make this entry
> do something. Is that correct?
Exactly.

The STIH407_RESET symbol is introduced in Reset sub-system.

The STiH407 reset has been merged in Philipp Zabel Reset tree for v3.19:
http://git.pengutronix.de/?p=pza/linux.git;a=shortlog;h=refs/heads/reset/for_v3.19

Commit: 3ba9204308eb51fe98fb1ab352c17d5319f26724

Best regards,
Maxime

>
>
> Paul Bolle
>
