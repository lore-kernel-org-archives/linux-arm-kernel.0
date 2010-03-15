From: jassisinghbrar@gmail.com (jassi brar)
Date: Mon, 15 Mar 2010 14:18:45 +0900
Subject: QUERY: How to handle sharing of interrupt between different
	peripherals.
In-Reply-To: <4B9DB99A.5040104@st.com>
References: <4B9DB99A.5040104@st.com>
Message-ID: <1b68c6791003142218q24fd8516id75d6964201da3f2@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 15, 2010 at 1:37 PM, Viresh KUMAR <viresh.kumar@st.com> wrote:
> In our SOC (SPEArxxx), we have few peripherals which share common interrupt
> line.
how about set_irq_chained_handler ?
