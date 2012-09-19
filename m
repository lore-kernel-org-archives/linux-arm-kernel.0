From: avi@redhat.com (Avi Kivity)
Date: Wed, 19 Sep 2012 15:44:14 +0300
Subject: [PATCH 00/15] KVM/ARM Implementation
In-Reply-To: <20120915153359.21241.86002.stgit@ubuntu>
References: <20120915153359.21241.86002.stgit@ubuntu>
Message-ID: <5059BE1E.2060504@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/15/2012 06:34 PM, Christoffer Dall wrote:
> The following series implements KVM support for ARM processors,
> specifically on the Cortex A-15 platform.  We feel this is ready to be
> merged.
> 
> Work is done in collaboration between Columbia University, Virtual Open
> Systems and ARM/Linaro.
> 

>From my point of view this looks ready to merge.  Once all outstanding
comments have been addressed, please collect ACKs from the ARM
maintainers (esp. for the non-kvm parts), and we can finally merge this.


-- 
error compiling committee.c: too many arguments to function
