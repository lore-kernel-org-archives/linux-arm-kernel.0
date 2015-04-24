From: bhaskarbudiredla@gmail.com (Bhaskara rao Budiredla)
Date: Fri, 24 Apr 2015 07:12:10 +0530
Subject: Programming the boundary between Inner and Outer caches on ARM
 architecture
In-Reply-To: <20150423095349.GB12732@n2100.arm.linux.org.uk>
References: <CAJWVF-w5YpZjRqnvbz1p70_WTBROL9vDkvYb_sG43nGp=s1vLg@mail.gmail.com>
 <20150420100119.GC24715@e104818-lin.cambridge.arm.com>
 <CAJWVF-xvca0MpKF1=GoyyffGTzxtvy_LoaZfjhwU27vSuyOHFA@mail.gmail.com>
 <20150421110038.GH30114@e104818-lin.cambridge.arm.com>
 <CAJWVF-wg1ROj_rwufJzszCR594NcJc89cW4R85ZSTQtissT4Bw@mail.gmail.com>
 <20150423095349.GB12732@n2100.arm.linux.org.uk>
Message-ID: <CAJWVF-xUx_raxFMQ7Un8utOo113D9j42Nuo8TWFrePABDvFELw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thanks Russell for the direction. Then the bug is somewhere within the
assembly source file head.s and must be specific to my local code
base. Got it!!

Thanks,
Bhaskara

On Thu, Apr 23, 2015 at 3:23 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Thu, Apr 23, 2015 at 12:12:34AM +0530, Bhaskara rao Budiredla wrote:
>> I am not sure why those are different. During Linux kernel
>> booting, I wrote a function to read the contents of NMRR in
>> build_mem_type_table( ) function. May be I need to sync up with boot
>> loader folks to check why those are set up with different cacheable
>> attributes. This difference was the reason to start this thread.
>
> NMRR is set by the Linux kernel.  Anything that the boot loader does is
> overwritten during the very early kernel boot.
>
> --
> FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
> according to speedtest.net.



-- 
.
