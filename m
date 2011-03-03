From: vipulkumar.samar@st.com (vksamar)
Date: Thu, 3 Mar 2011 17:34:50 +0530
Subject: clcdfb: Question about clcdfb_check() routine
Message-ID: <4D6F83E2.2020701@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

I had a doubt on clcdfb_check() routine in include/linux/amba/clcd.h.
Hard coded lower value of right margin, left margin and hsync len is (5+1).

Is there any specific reason behind it??
Can we make it 1 for more generic uses of the same??

If i am not wrong these values can vary from 0 to 255.

Thanks and Regards
Vipul Samar
