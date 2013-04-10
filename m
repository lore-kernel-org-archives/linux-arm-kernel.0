From: mmarek@suse.cz (Michal Marek)
Date: Wed, 10 Apr 2013 09:56:27 +0200
Subject: [PATCH] kbuild: generate generic headers before recursing into
 scripts
In-Reply-To: <m2k3ob1tar.fsf_-_@igel.home>
References: <CA+V-a8vYsBLVH-3Bm35Sv9K9ZMTcMB4_P_V3kBjyuEKDozPi5w@mail.gmail.com>
 <1363949290.3528.37.camel@linaro1.home> <m2ip48d62f.fsf@igel.home>
 <CA+V-a8srtwdf1H2JQwbkyMFhXopPEA90RM8Hy+UunM6Mm7-d1w@mail.gmail.com>
 <m2k3ob1tar.fsf_-_@igel.home>
Message-ID: <51651B2B.90206@suse.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 9.4.2013 19:57, Andreas Schwab wrote:
> The headers are now needed inside scripts/mod since 6543bec
> ("mod/file2alias: make modalias generation safe for cross compiling").
> 
> Signed-off-by: Andreas Schwab <schwab@linux-m68k.org>
> ---
> Prabhakar Lad <prabhakar.csengg@gmail.com> writes:
> 
>> Whats the status of it ?
> 
> I think it has sufficiently been tested by now.

Thanks a lot, I added it to kbuild.git#rc-fixes.

Michal
