From: timur@codeaurora.org (Timur Tabi)
Date: Wed, 15 Nov 2017 17:24:13 -0600
Subject: [PATCH v3 2/2] arm64: Add software workaround for Falkor erratum
 1041
In-Reply-To: <20171115010505.GO11955@codeaurora.org>
References: <1510537359-9978-1-git-send-email-shankerd@codeaurora.org>
 <1510537359-9978-3-git-send-email-shankerd@codeaurora.org>
 <20171115010505.GO11955@codeaurora.org>
Message-ID: <CAOZdJXW5CACx4n_ugKCHqjtGyft0gVAX7s5yAz0pEEs5NyYRmQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 14, 2017 at 7:05 PM, Stephen Boyd <sboyd@codeaurora.org> wrote:

> This also applies to Kryo CPUs. I have a patch[1] for the 1003
> Falkor errata that adds the Kryo MIDR check which can also be
> used for this errata.
>
> [1] https://patchwork.kernel.org/patch/10048987/

Please submit a follow-up patch for E1041 after our patch is merged.
We don't want to submit a patch for your SOCs, even if it's the same
erratum and work-around.

-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm
Technologies, Inc.  Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
