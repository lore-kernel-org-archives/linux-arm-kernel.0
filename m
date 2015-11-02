From: panand@redhat.com (Pratyush Anand)
Date: Mon, 2 Nov 2015 14:56:40 +0530
Subject: [PATCH 08/16] arm64/kexec: Add core kexec support
In-Reply-To: <56339ACD.7010506@arm.com>
References: <cover.1445297709.git.geoff@infradead.org>
 <a1c2a702f127d9dade1f9af8ab13decb2ef1c0da.1445297709.git.geoff@infradead.org>
 <56339ACD.7010506@arm.com>
Message-ID: <20151102092640.GA25166@dhcppc13.redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi James,

On 30/10/2015:04:29:01 PM, James Morse wrote:
> 
> >From 'kexec -e' to the first messages from the new kernel takes ~1 minute
> on Juno, Did you see a similar delay? Or should I go looking for what I've
> configured wrong!?

I did had similar issues with mustang, where it was taking more than 2 min.

Can you please try with my kexec-tools repo [1] where I have patches to enable
D-cache for sha verification. Your feedback might help to upstream these patches.

Thanks
~Pratyush

[1] https://github.com/pratyushanand/kexec-tools.git : master
