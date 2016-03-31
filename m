From: tj@kernel.org (Tejun Heo)
Date: Thu, 31 Mar 2016 12:43:28 -0400
Subject: [RFC PATCH 1/3] libahci: save port map for forced port map
In-Reply-To: <56FD4923.3090209@linaro.org>
References: <1459257075-21393-1-git-send-email-srinivas.kandagatla@linaro.org>
 <1459257075-21393-2-git-send-email-srinivas.kandagatla@linaro.org>
 <20160330185706.GQ7822@mtj.duckdns.org>
 <56FD4923.3090209@linaro.org>
Message-ID: <20160331164328.GA24661@htj.duckdns.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Thu, Mar 31, 2016 at 04:58:27PM +0100, Srinivas Kandagatla wrote:
> Yes, that is the intention, I guess, This was done exactly in case where the
> port number was fabricated too.
> 
> Without this I could not get the sata working on my board with forced port
> map option.

I see.  Looks good to me then.  Can you please respin the patches with
the updates for the review points in the second patch?  I'll apply
them to libata/for-3.6-fixes.

Thanks.

-- 
tejun
