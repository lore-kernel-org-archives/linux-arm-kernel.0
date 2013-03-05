From: akpm@linux-foundation.org (Andrew Morton)
Date: Tue, 5 Mar 2013 15:06:16 -0800
Subject: [PATCH v3 -next 0/5] Add support for LZ4-compressed kernel
In-Reply-To: <1362484056-9778-1-git-send-email-kyungsik.lee@lge.com>
References: <1362484056-9778-1-git-send-email-kyungsik.lee@lge.com>
Message-ID: <20130305150616.cb737f9b217b8c82051b2ccb@linux-foundation.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue,  5 Mar 2013 20:47:31 +0900 Kyungsik Lee <kyungsik.lee@lge.com> wrote:

> This is the third version. In this version, Some codes are fixed
> and more description and note are added. I would like to thank David Sterba
> for his review.
> 
> The Last patch[5/5] of the patch set is for making x86 and arm default to
> LZ4-compressed for testing the LZ4 code in the linux-next.
> It was requested by Andrew Morton in the patch set v2.
> 
> Currently, A preliminary version of LZ4 de/compression tool is supported.
> However, It is expected that we will have a tool with more features
> once its format is finished.

What happened to the changelog?  The earlier version at least had some
rudimentary benchmarking results, but now we don't even have that. 

Someone should prepare the information explaining why we added this to
Linux, and I'd prefer that person be you rather than me!  Certainly it
should include performance measurements - both speed and space.  Also
it should capture our thinking regarding all the other decompressors,
explaining why we view it as acceptable to add yet another one.

Please, put yourself in the position of someone reading these commits
in 2017 wondering "why did they merge this".  We should tell them.
