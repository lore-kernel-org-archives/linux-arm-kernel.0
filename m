From: festevam@gmail.com (Fabio Estevam)
Date: Thu, 14 Jun 2012 01:54:53 -0300
Subject: MXS getting AUART to work with DT.
In-Reply-To: <4FD96B3E.6080806@grid-net.com>
References: <4FD7EFFC.8010204@grid-net.com>
 <CAOMZO5BDFD3hHt+HW_sdh-3hCEwgJJA9C0ecAJZSOUCw_725Jw@mail.gmail.com>
 <4FD96B3E.6080806@grid-net.com>
Message-ID: <CAOMZO5Bc2ag4WLV+YwqpR7OOfMatd9CBBdT8koFabkPVcQacFw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 14, 2012 at 1:40 AM, Subodh Nijsure <snijsure@grid-net.com> wrote:

> With this change you will only see AUART0 being created all subsequent
> attempts fail. ?I think we need to have dt specific probe, my colleague Matt
> Burtch has implemented that dt specific probe for AUART will request him to
> send his diff tomorrow AM.
>
> I think something is broken in 3.5 as far as I can tell AUART goes it had
> worked for me in 3.4, I am novice at device-tree and was not sure if its
> because of DT or something else.

Ok, just tested linux-next and I see that mxs-auart probes correctly
for the non-dt kernel.

We need to fix mxs-auart for dt now.

Regards,

Fabio Estevam
