From: lkp@intel.com (kbuild test robot)
Date: Mon, 6 Mar 2017 10:16:04 +0800
Subject: [PATCH] MIPS: jump_lable: Give __jump_table elements an entsize.
In-Reply-To: <7fa95eea-20be-611c-2b63-fca600779465@caviumnetworks.com>
Message-ID: <201703061059.MZ3PD3Yi%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi David,

[auto build test ERROR on linus/master]
[also build test ERROR on v4.11-rc1 next-20170303]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/David-Daney/MIPS-jump_lable-Give-__jump_table-elements-an-entsize/20170228-231935
config: mips-allyesconfig (attached as .config)
compiler: mips-linux-gnu-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=mips 

All error/warnings (new ones prefixed by >>):

   {standard input}: Assembler messages:
>> {standard input}:968: Warning: entity size for SHF_MERGE not specified
>> {standard input}:968: Error: junk at end of line, first unrecognized character is `@'
>> {standard input}:968: Warning: ignoring changed section attributes for __jump_table
   {standard input}:987: Warning: entity size for SHF_MERGE not specified
   {standard input}:987: Error: junk at end of line, first unrecognized character is `@'
   {standard input}:987: Warning: ignoring changed section attributes for __jump_table
   {standard input}:1092: Warning: entity size for SHF_MERGE not specified
   {standard input}:1092: Error: junk at end of line, first unrecognized character is `@'
   {standard input}:1092: Warning: ignoring changed section attributes for __jump_table
   {standard input}:1113: Warning: entity size for SHF_MERGE not specified
   {standard input}:1113: Error: junk at end of line, first unrecognized character is `@'
   {standard input}:1113: Warning: ignoring changed section attributes for __jump_table

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 45689 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170306/b764249a/attachment-0001.gz>
