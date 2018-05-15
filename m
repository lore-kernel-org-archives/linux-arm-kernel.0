From: olof@lixom.net (Olof Johansson)
Date: Tue, 15 May 2018 13:48:21 -0700
Subject: [GIT PULL] arm64: dts: juno: updates for v4.18
In-Reply-To: <20180514162317.GB8409@e107155-lin>
References: <20180514162317.GB8409@e107155-lin>
Message-ID: <20180515204821.qxdnwl5u3rndg7if@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 14, 2018 at 05:23:17PM +0100, Sudeep Holla wrote:
> Hi ARM-SoC team,
> 
> Please pull !
> 
> Note that the tag is based on v4.17-rc3 instead of -rc1 as a fix went in
> -rc3 and conflicts with changes here. The conflicts themselves are
> trivial and hence I can based the change on -rc1 if required.
> 
> Regards,
> Sudeep
> 
> --
> 
> The following changes since commit 6da6c0db5316275015e8cc2959f12a17584aeb64:
> 
>   Linux v4.17-rc3 (2018-04-29 14:17:42 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux.git tags/juno-updates-4.18
> 
> for you to fetch changes up to 349b0f95e1ea718d912ca6875a40813e52a4ba39:
> 
>   arm64: dts: juno/rtsm: re-structure motherboard includes (2018-05-10 11:01:56 +0100)
> 
> ----------------------------------------------------------------
> ARMv8 Juno/Vexpress updates/cleanups for v4.18
> 
> 1. Add the missing connections to the STM output port as all endpoint
>    connections must be bidirectional.
> 
> 2. Replace all the custom OF graph endpoint node names with the standard
>    'endpoint'
> 
> 3. Cleanup to replace all underscores('_') with hyphens('-') in the
>    device node names
> 
> 4. Syntactic restructuring of motherboard include file so that it can be
>    included at the top of any other DTS file as it should be rather than
>    existing include in the middle of the file at a specific location

Merged, thanks!


-Olof
