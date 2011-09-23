From: robherring2@gmail.com (Rob Herring)
Date: Fri, 23 Sep 2011 07:46:26 -0500
Subject: Identifying Primecells
In-Reply-To: <CAKON4OxqqBh4xFLwiMZzsGrnoG8erQ0hMFX-_VA-EDMvdNkvQQ@mail.gmail.com>
References: <CAKON4OxqqBh4xFLwiMZzsGrnoG8erQ0hMFX-_VA-EDMvdNkvQQ@mail.gmail.com>
Message-ID: <4E7C7FA2.30404@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/22/2011 01:19 PM, jonsmirl at gmail.com wrote:
> I'm working on device tree support for the NXP LPC3130. To do this
> right I need to know what specific Primecells were used in the chip.
> How do I identify the primecell numbers for the devices? It is a
> 926ejs core.
> 

I'm not sure I understand the question.

The primecell periph id numbers are only in the DT if they are wrong in
the h/w for some reason. The compatible property should contain the
device model number (i.e. "arm,pl011" for the uart).

Rob
