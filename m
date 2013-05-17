From: srinivas.kandagatla@st.com (Srinivas KANDAGATLA)
Date: Fri, 17 May 2013 07:35:31 +0100
Subject: [PATCH] ARM: prima2: return rather than panic on missing DT nodes
In-Reply-To: <CAGsJ_4w_a=vXMeh-vbRKwD+KGqRNthx-zne=DR3iR7B-WqiUPw@mail.gmail.com>
References: <1368719437-28287-1-git-send-email-robherring2@gmail.com>
 <519510A4.8090904@st.com>
 <CAL_JsqL_z99EfT=3E32c0AS6fbwqOyTb7n+AzySmzJNyMCab3w@mail.gmail.com>
 <CAGsJ_4w_a=vXMeh-vbRKwD+KGqRNthx-zne=DR3iR7B-WqiUPw@mail.gmail.com>
Message-ID: <5195CFB3.4090905@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17/05/13 01:30, Barry Song wrote:
> then it turns out that moving the codes to callbacks of machine is the
> right way. i will take care the init ordering issues.

Not sure if this helps but, I have done a patch for this yesterday to
fix few more issues when booting with multi_v7_defconfig then the one
pointed out by Rob .

--srini
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0001-ARM-prima2-remove-early-and-postcore-initcalls.patch
Type: text/x-patch
Size: 4362 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130517/156c6278/attachment.bin>
