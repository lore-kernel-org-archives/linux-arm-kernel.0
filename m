From: daniel@iogearbox.net (Daniel Borkmann)
Date: Thu, 12 Jul 2018 23:12:45 +0200
Subject: [PATCH 00/14] ARM BPF jit compiler improvements
In-Reply-To: <20180712210236.GV17271@n2100.armlinux.org.uk>
References: <20180711093033.GP17271@n2100.armlinux.org.uk>
 <bf534d05-8f75-20bc-e25e-4536c1123585@iogearbox.net>
 <20180712210236.GV17271@n2100.armlinux.org.uk>
Message-ID: <fbfa3684-b5a0-670d-c8f7-8c14829565cb@iogearbox.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/12/2018 11:02 PM, Russell King - ARM Linux wrote:
> On Thu, Jul 12, 2018 at 09:02:41PM +0200, Daniel Borkmann wrote:
>> Applied to bpf-next, thanks a lot Russell!
> 
> Thanks, I've just sent four more patches, which is the sum total of
> what I'm intending to send for BPF improvements for the next merge
> window.

Great, thanks a lot for the batch of improvements, Russell!

Did you manage to get the BPF kselftest suite working on arm32 under
tools/testing/selftests/bpf/? In particular the test_verfier with
bpf_jit_enabled set to 1 and test_kmod.sh has a bigger number of
runtime tests that would stress it.

Thanks,
Daniel
