From: stefan.mavrodiev@gmail.com (stefan.mavrodiev at gmail.com)
Date: Fri, 15 Jul 2016 01:39:24 -0700 (PDT)
Subject: [PATCH 1/1] ARM: dts: sunxi: Add a olinuxino-lime2-emmc
In-Reply-To: <5732EB34.6070203@schinagl.nl>
References: <1461827998-12192-1-git-send-email-oliver@schinagl.nl>
 <CAGb2v66E2TuN3+tYaAbniV3q67waDZOfqKAW14VJz6xZFomZ=Q@mail.gmail.com>
 <57285162.2000704@schinagl.nl>
 <CAGb2v66r9m7qVW6BszeT2wqs0KyEr4x5ivTJYqu2Fes=R9-Ltw@mail.gmail.com>
 <CANCTEQgjiuQXcaw=3Dr5kUsTPc3nsDQf2odwzs4nHvrkREAqrg@mail.gmail.com>
 <5729F07C.3080308@schinagl.nl>
 <948be370-4401-43cb-862e-d4376755a75d@googlegroups.com>
 <5729F6D6.8030100@schinagl.nl>
 <4704fa35-9a2a-4e6e-8fd4-f4778405c598@googlegroups.com>
 <572A0052.9060202@schinagl.nl>
 <2e745ef7-ddc0-40fc-b867-414543690276@googlegroups.com>
 <572A10B3.2020803@schinagl.nl>
 <4375220a-f939-4ed0-a6d7-2cf887b07509@googlegroups.com>
 <9fe7ebb6-6d74-4b73-b6d6-93b79650cdb6@googlegroups.com>
 <9745a80b-5444-43f7-b772-68684c96c9e5@googlegroups.com>
 <57322C8D.5060806@schinagl.nl>
 <8afbe753-4e74-4b30-ad7e-a12027d28264@googlegroups.com>
 <57323CAB.7090202@schinagl.nl>
 <f959ee5c-fa63-48f6-9819-4822c055b928@googlegroups.com>
 <6bfa242e-c0ce-4dc5-9144-b3f16d8fb75c@googlegroups.com>
 <5732EB34.6070203@schinagl.nl>
Message-ID: <78b34fdb-bb6e-4043-8f5b-93bc551513c7@googlegroups.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olliver,

Why are you using nRST signal?
What I mean is this pin is inactive on this eMMC chip. To use the signal 
byte 162 of ECSD registers should be written.

On my board, this "reset" signal causes eMMC not to work.

Best regards,
Stefan Mavrodiev
