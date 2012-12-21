From: loic.pallardy@st.com (Loic PALLARDY)
Date: Fri, 21 Dec 2012 11:50:58 +0100
Subject: [PATCH 5/9] mailbox: change protection mechanisms
In-Reply-To: <B5906170F1614E41A8A28DE3B8D121433EC9CE80@DBDE01.ent.ti.com>
References: <1355836212-17956-1-git-send-email-loic.pallardy-ext@stericsson.com>
 <1355836212-17956-6-git-send-email-loic.pallardy-ext@stericsson.com>
 <B5906170F1614E41A8A28DE3B8D121433EC9CE80@DBDE01.ent.ti.com>
Message-ID: <50D43F12.8070105@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 12/21/2012 11:28 AM, Bedia, Vaibhav wrote:
> On Tue, Dec 18, 2012 at 18:40:08, Loic Pallardy wrote:
>> TX: replace spin by mutex
>> RX: replace spin_lock_irq by spin_lock_irqsave
>>
>
> Can you please add a short note on why this is being done?
>
Ok I'll add more information in commit message in next version.

Regards,
Loic

> Regards,
> Vaibhav
>
