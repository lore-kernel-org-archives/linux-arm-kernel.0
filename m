From: holgerschurig@gmail.com (Holger Schurig)
Date: Fri, 26 Feb 2016 09:22:29 +0100
Subject: [RFC v1] clk: Add debugfs nodes for
 enable/disable/set-rate/set-parent
In-Reply-To: <8B5B4FB66A982549A83D90C7791B761007F362D2E1@EAPEX1MAIL2.st.com>
 (Pankaj DEV's message of "Fri, 26 Feb 2016 16:06:48 +0800")
References: <1456454309-25037-1-git-send-email-pankaj.dev@st.com>
 <87fuwg9bog.fsf@gmail.com>
 <8B5B4FB66A982549A83D90C7791B761007F362D2E1@EAPEX1MAIL2.st.com>
Message-ID: <87twkvj2yi.fsf@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Pankaj DEV <pankaj.dev@st.com> writes:

> The prime motive for clk_set_rate is to set new rate for a clock,
> since the 'clk_rate' currently available, allows only reading.
> To provide reading rate from 'clk_set_rate' is just additional feature.

Sure.

But my point is to combine things.


After your patch:

- read via clk_rate
- read via clk_set_rate
- write via clk_set_rate

My proposal:

- read via clk_rate
- write via clk_rate
