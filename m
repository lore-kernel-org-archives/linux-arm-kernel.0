From: linnj@xilinx.com (John Linn)
Date: Wed, 22 Sep 2010 09:36:52 -0600
Subject: mpcore_wdt A9 questions
In-Reply-To: <AANLkTinQ34da0F0Xp_Rqh0F8fbh0lbSmD2Q68RLNDlIC@mail.gmail.com>
References: <1274090044-10236-1-git-send-email-viresh.kumar@st.com><AANLkTil2PtnsKdAHvW5-1WMQyTj6v3uLtrn2CNaZSXkc@mail.gmail.com><4BF12767.4010402@st.com><AANLkTikCC108eWniEBwzYsbkEUYQocICaLtd7FD_vMQ1@mail.gmail.com><20100518132050.GA8748@mvista.com>
	<4BF362F1.5070100@st.com>
	<AANLkTinQ34da0F0Xp_Rqh0F8fbh0lbSmD2Q68RLNDlIC@mail.gmail.com>
Message-ID: <99c9a321-49a1-42da-b49f-5cdd5c03e17a@SG2EHSMHS008.ehs.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

The A9 has a watchdog timer per CPU, but I don't see a way to use more
than one watchdog timer (one for each CPU) using the mpcore_wdt driver.

I tried to do my research but maybe I missed something. Is this a
limitation of watchdog timers in Linux or just this driver?

Thanks,
John



This email and any attachments are intended for the sole use of the named recipient(s) and contain(s) confidential information that may be proprietary, privileged or copyrighted under applicable law. If you are not the intended recipient, do not read, copy, or forward this email message or any attachments. Delete this email message and any attachments immediately.
