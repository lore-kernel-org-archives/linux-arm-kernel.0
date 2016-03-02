From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 2 Mar 2016 15:24:30 +0000
Subject: [PATCH v2 0/8] arm64: Support for systems without AArch32 state
In-Reply-To: <20160302150721.GA16286@yury-N73SV>
References: <1456393968-17386-1-git-send-email-suzuki.poulose@arm.com>
 <20160301211923.GA1325@yury-N73SV>
 <20160302150721.GA16286@yury-N73SV>
Message-ID: <20160302152429.GE11670@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 02, 2016 at 06:07:21PM +0300, Yury Norov wrote:
> ubuntu at arm64:~$ uname -a
> Linux arm64 4.5.0-rc5-00019-g3e330b9 #76 SMP PREEMPT Wed Mar 2 17:46:57 MSK 2016 aarch64 aarch64 aarch64 GNU/Linux
> 
> ubuntu at arm64:~$ cat /proc/cpuinfo
> processor       : 0-47
> BogoMIPS        : 200.00
> Features        : fp asimd evtstrm aes pmull sha1 sha2 crc32 atomics
> CPU implementer : 0x43
> CPU architecture: 8
> CPU variant     : 0x1
> CPU part        : 0x0a1
> CPU revision    : 0

As an aside, please do not hack up custom /proc/cpuinfo formats.

It is a compatibility nightmare for everyone.

Mark.
