From: holgerschurig@gmail.com (Holger Schurig)
Date: Fri, 26 Feb 2016 08:24:15 +0100
Subject: [RFC v1] clk: Add debugfs nodes for
 enable/disable/set-rate/set-parent
In-Reply-To: <1456454309-25037-1-git-send-email-pankaj.dev@st.com> (Pankaj
 Dev's message of "Fri, 26 Feb 2016 08:08:29 +0530")
References: <1456454309-25037-1-git-send-email-pankaj.dev@st.com>
Message-ID: <87fuwg9bog.fsf@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Pankaj Dev <pankaj.dev@st.com> writes:

> 1. clk_set_rate : Set new rate to value. Reading returns the
> current rate

If you can use this to set *and* read it, then "_set_" shouldn't be in
the name.

What is wrong with using the existing "clk_rate" for reading/setting the
rate?
