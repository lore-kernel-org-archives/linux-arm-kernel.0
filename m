From: tom.leiming@gmail.com (Ming Lei)
Date: Wed, 1 May 2013 16:53:47 +0800
Subject: [Question] flush_dcache_page() need to flush icache?
In-Reply-To: <20130501082238.GA10984@arm.com>
References: <CACVXFVMz3jLEPDYFM-_S_t5TiqikVSRiKf9cBNocH3QhVexwZg@mail.gmail.com>
 <20130430090502.GC29766@arm.com>
 <CACVXFVPz-rMiPyW2EE==v58LF6uTD1M1fKTNcF5a5+Z6-5u+Gg@mail.gmail.com>
 <20130430152635.GH29766@arm.com>
 <CACVXFVNUu9HKY+Vo7VLWGC3rQoj7TUwC3kfpEsf5kCEibMcThg@mail.gmail.com>
 <20130501082238.GA10984@arm.com>
Message-ID: <CACVXFVMCmzESFW_E+1tE9h_yHAnKVwMyot6RSHicAD91HQeQOA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 1, 2013 at 4:22 PM, Catalin Marinas <catalin.marinas@arm.com> wrote:
>
> It depends on the definition of 'self'. If by that you mean the user
> application, it hasn't modified itself and it can't trigger
> flush_dcache_page().

Yes, you are right, and it is the case in which one user application
modifies code of another application. I mean if it is possible to flush
icache only under this situation, which should be very rare.


Thanks,
-- 
Ming Lei
