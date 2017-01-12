From: fweimer@redhat.com (Florian Weimer)
Date: Thu, 12 Jan 2017 17:13:25 +0100
Subject: [Question] New mmap64 syscall?
In-Reply-To: <20170103205437.GA22548@amd>
References: <20161206185440.GA4654@yury-N73SV>
 <f544bcc3-8aae-1bd0-b744-9964fc038a51@redhat.com>
 <20161207154811.GA15248@yury-N73SV>
 <14981df2-b120-17c3-a5a8-5cbbd2008c4f@redhat.com>
 <20170103205437.GA22548@amd>
Message-ID: <59af3a6f-f30c-46a5-2d0b-6a7e36668e6b@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/03/2017 09:54 PM, Pavel Machek wrote:
> ...actually, with strace and batched interface, it will be impossible
> to see what is going on because of races. So I'm not sure if I like
> the batched interface at all...

I'm not sure if I understand this problem.

ioctl, fcntl, most socket system calls, even open all have this problem 
as well, right?

Thanks,
Florian
