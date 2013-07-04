From: festevam@gmail.com (Fabio Estevam)
Date: Thu, 4 Jul 2013 12:49:14 -0300
Subject: imx25: How to get frame buffer device in a system using device
 tree
In-Reply-To: <51D597A4.2010608@eurekelettronica.it>
References: <CAO8h3eFq9WhvZYbbeFfWgVEXViR8MAcGaztsvvaLpFSW-W6CfA@mail.gmail.com>
 <CAOMZO5Aat-iAN_TJ6BXEopB+WCkKgLjWh67sCXg0jd1DtzmKSQ@mail.gmail.com>
 <51D597A4.2010608@eurekelettronica.it>
Message-ID: <CAOMZO5DLvHDMedq5P5bwg3kdjrFnaOibgxujJj29XLSiZn4Hag@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 4, 2013 at 12:41 PM, gianluca
<gianlucarenzi@eurekelettronica.it> wrote:

> The links above are valid as skeleton for a imx28 based board?

No, these examples are for mx27. mx25 and mx27 share the same video controller.

For a mx28 example, you can refer to imx28-evk.dts.
