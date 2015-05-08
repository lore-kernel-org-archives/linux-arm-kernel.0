From: ast@plumgrid.com (Alexei Starovoitov)
Date: Fri, 08 May 2015 08:30:05 -0700
Subject: [PATCH] arm64: bpf: fix signedness bug in loading 64-bit immediate
In-Reply-To: <20150508151704.GF25587@arm.com>
References: <1431063591-16668-1-git-send-email-xi.wang@gmail.com>
 <20150508083856.GA2125@arm.com>
 <CAKU6vybvWvoF2Om0D-tPp0N-_4Oj3o44hnbmrnEtyNN8XeBAHg@mail.gmail.com>
 <20150508151704.GF25587@arm.com>
Message-ID: <554CD67D.8040408@plumgrid.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 5/8/15 8:17 AM, Will Deacon wrote:
>
> Ok, I plan to apply the patch below for 4.1.

great catch. Looks good to me.
Xi, could you send a separate patch for test_bpf update to net-next?
Thanks!
