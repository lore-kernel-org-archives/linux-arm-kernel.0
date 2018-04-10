From: alexander.sverdlin@nokia.com (Alexander Sverdlin)
Date: Tue, 10 Apr 2018 15:59:41 +0200
Subject: [PATCH v5 2/3] ARM: ftrace/recordmcount: filter relocation types
In-Reply-To: <DM5PR2101MB1032EF6B16414765AA0BAB19FBBE0@DM5PR2101MB1032.namprd21.prod.outlook.com>
References: <20180406143939.14642-3-alexander.sverdlin@nokia.com>
 <DM5PR2101MB1032EF6B16414765AA0BAB19FBBE0@DM5PR2101MB1032.namprd21.prod.outlook.com>
Message-ID: <85c043e6-2926-33a2-3d3a-572fbfe905bb@nokia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Sasha,

On 10/04/18 15:50, Sasha Levin wrote:
> This commit has been processed by the -stable helper bot and determined
> to be a high probability candidate for -stable trees. (score: 46.9374)
> 
> The bot has tested the following trees: v4.16.1, v4.15.16, v4.14.33, v4.9.93, v4.4.127.
> 
> v4.16.1: Build OK!
> v4.15.16: Build OK!
> v4.14.33: Build OK!
> v4.9.93: Failed to apply! Possible dependencies:
>     9648dc15772d ("recordmcount: arm: Implement make_nop")
> 
> v4.4.127: Failed to apply! Possible dependencies:
>     9648dc15772d ("recordmcount: arm: Implement make_nop")
> 
> 
> Please let us know if you'd like to have this patch included in a stable tree.

IMO this doesn't make sense to include this in stable alone, I cannot imagine
compiler would ever generate something broken with the current sources.

It only makes sense with the whole series, but I personally do not think
the whole series belongs to stable.

-- 
Best regards,
Alexander Sverdlin.
