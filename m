From: varkab@cdac.in (Varka Bhadram)
Date: Fri, 13 Jun 2014 17:07:10 +0530
Subject: device tree: compilation of device tree sources
Message-ID: <539AE266.70306@cdac.in>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I cloned the device tree git from: 
https://kernel.googlesource.com/pub/scm/linux/kernel/git/devicetree/devicetree-rebasing

When i try to compile the Makefile is throwing errors like this:

DTC     src/arc/abilis_tb100_dvk.dtb

dtc: invalid option -- 'i'

Usage:

     dtc [options] <input file>

Options:

     -h

         This help text

     -q

         Quiet: -q suppress warnings, -qq errors, -qqq all

     -I <input format>

         Input formats are:

             dts - device tree source text

             dtb - device tree blob

             fs - /proc/device-tree style directory

     -o <output file>

     -O <output format>

         Output formats are:

             dts - device tree source text

             dtb - device tree blob

             asm - assembler source

     -V <output version>

         Blob version to produce, defaults to 17 (relevant for dtb

         and asm output only)

     -d <output dependency file>

     -R <number>

         Make space for <number> reserve map entries (relevant for

         dtb and asm output only)

     -S <bytes>

         Make the blob at least <bytes> long (extra space)

     -p <bytes>

         Add padding to the blob of <bytes> long (extra space)

     -b <number>

         Set the physical boot cpu

     -f

         Force - try to produce output even if the input tree has errors

     -s

         Sort nodes and properties before outputting (only useful for

         comparing trees)

     -v

         Print DTC version and exit

     -H <phandle format>

         phandle formats are:

             legacy - "linux,phandle" properties only

             epapr - "phandle" properties only

             both - Both "linux,phandle" and "phandle" properties

make[1]: *** [src/arc/abilis_tb100_dvk.dtb] Error 3

make: *** [all_arc] Error 2


The way of using the dtc command is wrong.


Thanks,
Varka Bhadram

-------------------------------------------------------------------------------------------------------------------------------
[ C-DAC is on Social-Media too. Kindly follow us at:
Facebook: https://www.facebook.com/CDACINDIA & Twitter: @cdacindia ]

This e-mail is for the sole use of the intended recipient(s) and may
contain confidential and privileged information. If you are not the
intended recipient, please contact the sender by reply e-mail and destroy
all copies and the original message. Any unauthorized review, use,
disclosure, dissemination, forwarding, printing or copying of this email
is strictly prohibited and appropriate legal action will be taken.
-------------------------------------------------------------------------------------------------------------------------------
